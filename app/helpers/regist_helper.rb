module RegistHelper
  def tD(scope, name)
    <<-HTML
      <tr ng-if="!!(registData.#{scope})">
        <td> #{name} </td>
        <td> {{registData.#{scope}}} </td>
      </tr>
    HTML
  end
end
